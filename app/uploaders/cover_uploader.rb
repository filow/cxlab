# encoding: utf-8
class CoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/contest_cover/#{mounted_as}/#{model.id}"
  end

  # 调整临时文件的存放路径，默认是在 public 下面
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resize_to_fit => [300, 300]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [64, 64]
  end

  version :icon,:from_version=> :thumb do
    process :resize_to_fit => [32, 32]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def colorname
    return @main_color if @main_color
    # 读取文件
    img =  Magick::Image.read(file.file).first
    # 要分析的方块的大小
    squre = 30
    summarize_size = 256
    # 首先缩小图像
    small  = img.resize_to_fill(squre,squre)
    pixel = small.get_pixels(0,0,squre,squre)
    # 分析图像的每个像素，并统计
    color_counter = Hash.new
    pixel.each do |x|
        key = sprintf("%02x%02x%02x",x.red/summarize_size,x.green/summarize_size,x.blue/summarize_size)
        if color_counter[key]
            color_counter[key]+=1
        else
            color_counter[key]=1
        end
    end
    # 去除一些特殊值
    color_counter['ffffff']=0
    color_counter['000000']=0
    @main_color = color_counter.max_by{|key,value| value}[0]
    return @main_color

  end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    Digest::SHA2.hexdigest(original_filename)[0..6]+'|'+colorname+".jpg" if original_filename
  end

end
