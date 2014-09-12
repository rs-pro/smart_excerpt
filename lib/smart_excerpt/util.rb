module SmartExcerpt
  module Util
    def decode(str)
      @@he.decode(str)
    end

    def encode(str)
      @@he.encode(str)
    end

    def strip_tags(str)
      @@h.strip_tags(str)
    end

    def decode_and_strip(str)
      self.strip_tags(self.decode(str))
    end

    def truncate(str, opts = {})
      return '' if str.blank?
      tx = str.gsub(/<h\d[^>]*?>(.*)<\/h\d>/mi, '').gsub("\n", ' ').gsub("\r", '').gsub("\t", '').strip
      tx = @@he.decode(tx)
      tx = @@h.strip_tags(tx)
      @@h.smart_truncate(tx, opts)
    end
  end
end

