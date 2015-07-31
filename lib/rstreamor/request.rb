module Rstreamor
  class Request

    def initialize(request, file)
      self.request = request
      self.file = file
    end

    def ranges
      self.request.headers['HTTP_RANGE'].gsub('bytes=', '').split('-')
    end

    def upper_bound
      ranges[0] ? ranges[0].to_i : 0
    end

    def lower_bound
      ranges[1] ? ranges[1].to_i : self.file.data.size
    end

    def range_header?
      self.request.headers['HTTP_RANGE'].present?
    end

    def file_content_type
      self.file.content_type
    end

    def slice_file(from_byte, to_byte)
      self.file.data.byteslice(lower_bound, upper_bound)
    end

  end
end