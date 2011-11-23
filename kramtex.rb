#! /usr/bin/ruby

require 'rubygems'
require 'kramdown'
require 'header.rb'
require 'yaml'

module KramTeX
  class Document

    attr_accessor :headers
    attr_accessor :content, :data, :output

    # Returns the contents as a String.
    def to_s
      return self.content || ''
    end

    def initialize(filename, type="article")
      @filename = filename

      read_yaml

      puts @data.inspect

      @headers = LaTeXheaders.new( @data )
    end
    
    # Read the YAML frontmatter.
    # Returns nothing.
    def read_yaml
      @content = open_file

      if @content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)^(.*)/m
        @content = $3

        begin
          @data = YAML.load( $1 )
        rescue => e
          puts "YAML Exception reading #{@filename}.markdown: #{e.message}"
        end

          @data = @data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      end

      @data ||= {}
    end

    def open_file
      file = nil
      File.open("#{@filename}.markdown", "r") { |f| file = f.read }
      return file
    end

    def convert_to_document file
      headers = ['section*','subsection*','subsubsection*',
        'paragraph*','subparagraph*','']

      document = Kramdown::Document.new(@content.to_s, :latex_headers => headers)
      document = document.to_latex

      @headers.generate
      document = @headers.header + document.to_s + @headers.end
      yield document
    end

    def write_output document
      File.open("#{@filename}.tex", 'w') { |f| f.write(document) }
    end

  end
end

