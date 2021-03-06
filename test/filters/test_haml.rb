# encoding: utf-8

require 'test/helper'

class Nanoc3::Filters::HamlTest < MiniTest::Unit::TestCase

  include Nanoc3::TestHelpers

  def test_filter
    if_have 'haml' do
      # Create filter
      filter = ::Nanoc3::Filters::Haml.new({ :question => 'Is this the Payne residence?' })

      # Run filter (no assigns)
      result = filter.run('%html')
      assert_match(/<html>.*<\/html>/, result)

      # Run filter (assigns without @)
      result = filter.run('%p= question')
      assert_equal("<p>Is this the Payne residence?</p>\n", result)

      # Run filter (assigns with @)
      result = filter.run('%p= @question')
      assert_equal("<p>Is this the Payne residence?</p>\n", result)
    end
  end

  def test_filter_with_params
    if_have 'haml' do
      # Create filter
      filter = ::Nanoc3::Filters::Haml.new({ :foo => 'bar' })

      # Check with HTML5
      result = filter.run('%img', :format => :html5)
      assert_match(/<img>/, result)

      # Check with XHTML
      result = filter.run('%img', :format => :xhtml)
      assert_match(/<img\s*\/>/, result)
    end
  end

  def test_filter_error
    if_have 'haml' do
      # Create filter
      filter = ::Nanoc3::Filters::Haml.new({ :foo => 'bar' })

      # Run filter
      raised = false
      begin
        filter.run('%p= this isn\'t really ruby so it\'ll break, muahaha')
      rescue SyntaxError => e
        e.message =~ /(.+?):\d+: /
        assert_match '?', $1
        raised = true
      end
      assert raised
    end
  end

  def test_filter_with_yield
    if_have 'haml' do
      # Create filter
      filter = ::Nanoc3::Filters::Haml.new({ :content => 'Is this the Payne residence?' })

      # Run filter 
      result = filter.run('%p= yield')
      assert_equal("<p>Is this the Payne residence?</p>\n", result)
    end
  end

end
