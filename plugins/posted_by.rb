require 'open-uri'
require 'json'

module Jekyll
  class PostedByTag < Liquid::Tag
    @@api_key = Jekyll.configuration({})['posted_by']['google_api_key']
    @@api_key = nil if @@api_key == ""

    def initialize(tag_name, text, token)
      super
      @text           = text
      @cache_disabled = false
      @cache_folder   = File.expand_path "../.postedby-cache", File.dirname(__FILE__)
      FileUtils.mkdir_p @cache_folder
    end

    def render(context)
      def context.get(key)
        return self["post.#{key}"].to_s if self["post.#{key}"] && self["post.#{key}"] != ""
        return self["page.#{key}"].to_s if self["page.#{key}"] && self["page.#{key}"] != ""
        return nil
      end

      author = context.get("author")
      googleplus_user = context.get("googleplus_user")
      twitter_user = context.get("twitter_user")
      facebook_user = context.get("facebook_user")
      github_user = context.get("github_user")
      
      return build_html(author, googleplus_user, twitter_user, facebook_user, github_user)
    end

    def build_html(author, googleplus_user, twitter_user, facebook_user, github_user)
      return <<HTML
  <section>
    <h1>Posted By</h1>
    <div>
      <ul class="editor-profile">
        #{build_profile_image_html(googleplus_user)}
        <li>
          <ul class="profile-list">
            #{build_author_html(author, googleplus_user)}
            #{build_github_html(github_user)}
            #{build_twitter_html(twitter_user)}
            #{build_facebook_html(facebook_user)}
          </ul>
        </li>
      </ul>
    </div>
    <div style="clear: both"></div>
  </section>
HTML
    end

    def build_profile_image_html(googleplus_user)
      return "" if !googleplus_user || !@@api_key

      filename = File.join(@cache_folder, googleplus_user.gsub(/\+/, "_"))

      img_url = get_googleplus_profile_image(googleplus_user, @@api_key, filename)

      return <<HTML
        <li class="avatar">
          <a href="https://plus.google.com/#{googleplus_user}?rel=author"><img src="#{img_url}?sz=64" /></a>
        </li>
HTML
    end

    def get_googleplus_profile_image(user_id, api_key, filename)
      url = from_cache(filename)

      if !url
        url = from_web(user_id, api_key)
        cache(filename, url)
      end

      return url
    end

    def from_cache(filename)
      return nil if @cache_disabled || !File.exist?(filename)
      return File.read(filename)
    end

    def from_web(user_id, api_key)
      open("https://www.googleapis.com/plus/v1/people/#{user_id}?key=#{api_key}") do |input|
        json = JSON.load(input)
        url = json["image"]["url"]
        url = url.gsub(/\?sz\=(\d+)/, "")
        return url
      end
    end

    def cache(filename, url)
      File.open(filename, "w") do |out|
        out.write(url)
      end
    end

    def build_author_html(author, googleplus_user)
      return "<li>#{author}</li>" if !googleplus_user
      return "<li><a href='https://plus.google.com/#{googleplus_user}?rel=author'>#{author}</a></li>"
    end

    def build_github_html(github_user)
      return "" if !github_user
      return <<HTML
            <li class="social-icon">
              <a href="https://github.com/#{github_user}"><img src="/images/posted_by/github.png" /></a>
            </li>
HTML
    end

    def build_twitter_html(twitter_user)
      return "" if !twitter_user
      return <<HTML
            <li class="social-icon">
              <a href="https://twitter.com/#{twitter_user}"><img src="/images/posted_by/twitter.png" /></a>
            </li>
HTML
    end

    def build_facebook_html(facebook_user)
      return "" if !facebook_user
      return <<HTML
            <li class="social-icon">
              <a href="https://facebook.com/#{facebook_user}"><img src="/images/posted_by/facebook.png" /></a>
            </li>
HTML
    end
  end
end

Liquid::Template.register_tag('posted_by', Jekyll::PostedByTag)
