module SmartExcerpt
  module Util
    def decode(str)
      SmartExcerpt.he.decode(str)
    end

    def encode(str)
      SmartExcerpt.he.encode(str)
    end

    def strip_tags(str)
      SmartExcerpt.h.strip_tags(str)
    end

    def decode_and_strip(str)
      self.strip_tags(self.decode(str))
    end

    def simple_format(str)
      SmartExcerpt.h.simple_format(str)
    end

    def truncate(str, opts = {})
      return '' if str.blank?
      tx = str.gsub(/<h\d[^>]*?>(.*)<\/h\d>/mi, '').gsub("\n", ' ').gsub("\r", '').gsub("\t", '').strip
      tx = SmartExcerpt.he.decode(tx)
      tx = SmartExcerpt.h.strip_tags(tx)
      SmartExcerpt.h.smart_truncate(tx, opts)
    end
  end
end

