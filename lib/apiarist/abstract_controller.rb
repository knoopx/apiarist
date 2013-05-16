require 'action_controller/metal'

module Apiarist
  class AbstractController < ActionController::Metal
    SKIP_MODULES = [:Cookies, :Flash, :RequestForgeryProtection, :HttpAuthentication]

    abstract!

    module Compatibility
      def cache_store; end
      def cache_store=(*); end
      def assets_dir=(*); end
      def javascripts_dir=(*); end
      def stylesheets_dir=(*); end
      def page_cache_directory=(*); end
      def asset_path=(*); end
      def asset_host=(*); end
      def relative_url_root=(*); end
      def perform_caching=(*); end
      def helpers_path=(*); end
      def allow_forgery_protection=(*); end
      def helper_method(*); end
      def helper(*); end
    end

    extend Compatibility
    ActionController::Base.without_modules(SKIP_MODULES).each { |mod| include mod }
    ActiveSupport.run_load_hooks(:action_controller, self)
  end
end