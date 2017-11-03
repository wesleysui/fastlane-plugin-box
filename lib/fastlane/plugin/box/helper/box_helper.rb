module Fastlane
  module Helper
    class BoxHelper
      # class methods that you define here become available in your action
      # as `Helper::BoxHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the box plugin helper!")
      end
    end
  end
end
