# frozen_string_literal: true

require "test_helper"

class UnrichTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Unrich::VERSION
  end

  def test_that_it_reads
    assert_equal Unrich::Text, ::Unrich::Text.read("{}").class
  end

  def test_that_it_reads_from_file
    assert_equal Unrich::Text,
                 ::Unrich::Text.read(File.open(File.join(File.dirname(__FILE__), "fixtures", "basic.rtf"))).class
    assert_equal String,
                 ::Unrich::Text.read(File.open(File.join(File.dirname(__FILE__), "fixtures",
                                                         "basic.rtf"))).rtf_text.class
  end

  def test_encoding
    assert_equal "Windows-1252", read(:basic).encoding
  end

  def test_to_txt_basic
    unrich_text = read(:basic)
    assert_equal "very basic text", unrich_text.to_txt
  end

  def test_to_txt_code_points
    unrich_text = read(:codepoints)
    assert_equal "Dutch text with code points

vréémde tekens
En een prijsje €100,-", unrich_text.to_txt
  end

  def test_to_txt_sample1
    unrich_text = read(:sample1)
    assert_equal "Kunstadviseur: Antoine
Datum volgende ruiling: 08.2011
Opmerkingen: In 2011 budget van ongeveer € 1500,- 24.11.2010 dodo

F45.012

12/10/2011 gesproken iemand. EG", unrich_text.to_txt
  end

  def test_to_txt_sample2
    unrich_text = read(:sample2)
    assert_equal "29/11/2017 ktg 1104,83 weggeboekt dvr \nann 01/2012 afstand bezwaar komt werk kopen van stg dvr 21/11/11\n\n14/11/11 bri tarief 2012\nkorting -4% jan 2013", unrich_text.to_txt
  end

  private

  def read fixture_name
    ::Unrich::Text.read(File.open(File.join(File.dirname(__FILE__), "fixtures", "#{fixture_name}.rtf")))
  end
end
