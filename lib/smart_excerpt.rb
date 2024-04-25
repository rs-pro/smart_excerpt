require "smart_excerpt/version"
require 'htmlentities'
require "smart_excerpt/util"
require "smart_excerpt/helper"

module SmartExcerpt
  extend Util

  @@h = Helper.new
  @@he = HTMLEntities.new
  mattr_reader :h
  mattr_reader :he

  def self.included(base)
    base.send(:extend, ClassMethods)
  end


  def smart_truncate(obj, base_field, excerpt_field, words)
    trust_multiplier = 1.2
    if words.is_a?(Hash) && words[:trust_multiplier]
      trust_multiplier = words[:trust_multiplier]
    end

    if obj.send(excerpt_field).blank?
      tx = obj.send(base_field)
    else
      tx = obj.send(excerpt_field)
      if words.is_a?(Numeric)
        words *= trust_multiplier
      elsif words.is_a?(Hash)
        if words[:trust_excerpts]
          words = {words: Float::INFINITY}
        else
          words = Hash[words.map {|k, v| [k, v.is_a?(Numeric) ? (v * trust_multiplier).to_i : v] }]
        end
      end
    end

    if words.is_a?(Numeric)
      options = {words: words.to_i}
    elsif words.is_a?(Hash)
      options = words
    else
      raise 'bad parameter for get_excerpt'
    end

    if tx.blank?
      ''
    else
      # kill headers and newlines
      unless options[:keep_headers]
        tx = tx.gsub(/<h\d[^>]*?>(.*?)<\/h\d>/mi, '')
      end
      unless options[:keep_newlines]
        tx = tx.gsub("\n", ' ').gsub("\r", '').gsub("\t", '').strip
      end
      tx = @@he.decode(tx)
      unless options[:keep_html]
        tx = @@h.strip_tags(tx)
      end
      @@h.smart_truncate(tx, options)
    end
  end


  module ClassMethods
    def smart_excerpt(excerpt_field, base_field, words = 25)
      define_method("get_#{excerpt_field}".to_sym) do |c_words = words|
        smart_truncate(self, base_field, excerpt_field, c_words)
      end
    end
  end
end

