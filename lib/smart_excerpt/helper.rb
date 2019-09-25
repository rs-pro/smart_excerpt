module SmartExcerpt
  class Helper
    include ActionView::Helpers::TextHelper

    def smart_truncate(s, opts = {})
      return '' if s.blank?
      opts = {words: 25}.merge(opts)
      if opts[:sentences]
        return s.split(/\.(\s|$)+/).delete_if {|s| s.blank? }[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
      end
      if opts[:letters]
        return truncate(s, length: opts[:letters], separator: ' ', omission: '...')
      end
      n = opts[:words]
      if n === Float::INFINITY
        return s
      end
      a = s.split(/\s/) # or /[ ]+/ to only split on spaces
      r = a[0...n].join(' ') + (a.size > n ? '...' : '')

      # replace &nbsp; with regular spaces
      r.gsub!(' ', ' ')

      # strip newlines
      r = r.strip.gsub("\r", '').gsub("\n", ' ')

      r.gsub(/\s+/, ' ')
    end
  end
end
