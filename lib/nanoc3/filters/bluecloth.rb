module Nanoc3::Filters
  class BlueCloth < Nanoc3::Filter

    def run(content)
      require 'bluecloth'

      ::BlueCloth.new(content).to_html
    end

  end
end
