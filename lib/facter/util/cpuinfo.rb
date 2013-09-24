module Facter::Util::Cpuinfo
  class ParseError < StandardError
  end

  # Parses the specified file in Linux `/proc/cpuinfo` format into an Array of
  # Hashes structure where each array element represents one CPU/core/processor
  # and the hash contains all of the associated key/value pairs with that unit.
  #
  # @param cpuinfo [String] the file path to parse, defaults to `/proc/cpuinfo`
  # @return [Array] of [Hash] of parsed cpuinfo
  def self.parse(cpuinfo = '/proc/cpuinfo')
    processor_num  = -1
    processor_list = []

    unless File.exists?(cpuinfo)
      return nil
    end

    # parse /proc/cpuinfo and return the CPUs in the order that we encounter
    # them. the old method was trying to order the CPUs in the array by the
    # processor id but on some platforms this is a string instead of a numeric
    # value.
    File.readlines(cpuinfo).each do |line|
      if line =~ /^processor\s+:\s+(\d+)/
        processor_num += 1
      elsif line =~ /^processor\s+(\d+):\s+(.*)/
        # XXX what platform is this regex for? There are no example fixtures
        # that match this pattern
        processor_num += 1
      end

      # if we've parsed the first line and we haven't seen a ^processor.* line
      # something is wrong
      if processor_num < 0
        raise ParseError, "First line '#{line}' must match processor\s+"
      end

      processor_list[processor_num] ||= {}

      # store all cpuinfo entries for this CPU as key/value pairs
      if m = line.match(/^(.+\w)\s+:\s+(.*)/)
        # transliterate spaces to underscores for the hash keys
        # eg "cpu family" -> "cpu_family"
        # XXX should the keys be turned into symbols?
        key   = m[1].downcase.gsub(/\s/, '_')
        value = m[2].strip

        processor_list[processor_num][key] = value
      end
    end

    return processor_list
  end

end
