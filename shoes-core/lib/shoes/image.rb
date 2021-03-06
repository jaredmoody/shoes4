# frozen_string_literal: true

class Shoes
  class Image < Common::UIElement
    include Common::Clickable
    include Common::Hover
    include Common::ImageHandling

    BINARY_ENCODING = Encoding.find('binary')

    style_with :art_styles, :common_styles, :dimensions, :file_path

    STYLES = { fill: Shoes::COLORS[:black] }.freeze

    def before_initialize(styles, file_path_or_data)
      styles[:file_path] = normalized_source(file_path_or_data)
    end

    def path
      @style[:file_path]
    end

    def path=(path_or_data)
      style(file_path: normalized_source(path_or_data))
      @gui.update_image
    end

    def url?(path_or_data)
      path_or_data =~ %r{^https?://}
    end

    def raw_image_data?(name_or_data)
      name_or_data.encoding == BINARY_ENCODING
    end

    private

    def normalized_source(path_or_data)
      return path_or_data if raw_image_data?(path_or_data)
      return path_or_data if url?(path_or_data)
      absolute_file_path(path_or_data)
    end
  end
end
