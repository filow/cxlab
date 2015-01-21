require 'RMagick'
include Magick
class VerifyCode
    def self.build(args={})
        code_set = '3456789ABCDEFGHJKLMNPQRTUVWXY'
        default_option = {size: 4, curve: true, noise: true, font_size: 25, filename: "vcode"}
        default_option[:bgcolor] = ["#FFF4F4","#FCFAE1","#E9FCE1","#E1FCF8","#E1E2FC"]
        option = default_option.merge(args)
        # 图片的宽度(px)
        option[:length] ||= (option[:size]+1) * option[:font_size] * 1.5
        # 图片的高度(px)
        option[:height] ||= option[:font_size] * 2

        image = Image.new(option[:length], option[:height]){ self.background_color = option[:bgcolor][rand(option[:bgcolor].length)]}
        drawer = Magick::Draw.new

        ttf = "lib/fonts/#{rand(4)}.ttf"

        code = ""
        lmargin = 0
        option[:size].times do |x|
            code[x]=code_set[rand(code_set.length)]
            lmargin += rand(option[:font_size]*0.4)+option[:font_size]*1.2
            tmargin = option[:font_size]/2+option[:height]/2+rand(16)-8
            font_color = "rgba(#{rand(120)},#{rand(120)},#{rand(120)},#{(rand(6)+4).to_f/10})"
            drawer.annotate(image, 0, 0, lmargin, tmargin, code[x]) do
                self.font = ttf
                self.pointsize = option[:font_size]
                self.fill = font_color
                self.affine = AffineMatrix.new(1,rand(),rand(),1.9,0,0)
            end
        end


        # 添加散点
        2.times do |x|
            font_color = "rgb(#{rand(120)},#{rand(120)},#{rand(120)})"
            rand_text = code_set[rand(code_set.length)]
            7.times do
                drawer.annotate(image, 0, 0, rand(option[:length]), rand(option[:height]), rand_text) do
                    self.pointsize = rand(9)+5
                    self.fill = font_color
                end
            end
        end
        image.format = "PNG"
        {code: code, blob: image.to_blob}

    end

end
