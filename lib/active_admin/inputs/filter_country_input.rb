module ActiveAdmin
  module Inputs
    class FilterCountryInput < FilterSelectInput
      include FilterBase

      def collection
        ::ActionView::Helpers::FormOptionsHelper::COUNTRIES
      end

    end
  end
end