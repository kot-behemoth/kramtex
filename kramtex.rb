#! /usr/bin/ruby

require 'rubygems'
require 'kramdown'
require 'header.rb'

module KramTeX
  class Document

    def initialize(filename, type="article")
      @filename = filename
      @headers = LaTeXheaders.new(:title => "Test")
    end

    def open_file
      file = File.open("#{@filename}.markdown", "r").read
      yield file
    end

    def convert_to_document file
      document = Kramdown::Document.new(file)
      document = document.to_latex
      document = @headers.header + document.to_s + @headers.end
      yield document
    end

    def write_output document
      File.open("#{@filename}.tex", 'w').write(document)
    end

  end
end

