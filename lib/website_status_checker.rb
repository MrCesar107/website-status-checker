# frozen_string_literal: true

require 'net/http'

module WebsiteStatusChecker
  AVAILABLE_STATUSES = %w[200 301 302].freeze

  class Client
    attr_reader :uri

    def initialize(uri)
      @uri = URI(uri)
    end

    def call
      return "INVALID URL" unless valid_url?

      status_code = get_website_status_code

      if AVAILABLE_STATUSES.include?(status_code)
        "WEBSITE IS AVAILABLE"
      else
        "WEBSITE IS UNAVAILABLE"
      end
    end

    private

    def get_website_status_code
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      response.code
    end

    def valid_url?
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    end
  end
end
