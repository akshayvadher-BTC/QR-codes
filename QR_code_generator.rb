require 'prawn/qrcode'
require 'prawn/measurement_extensions'

def generate_qr_code_and_render_in_pdf
  pdf = Prawn::Document.new(page_size: [70.mm, 40.mm], margin: [19,19,19,19])
  pdf.font_size 8
  array = %w[iron joker john joel tim hydra phenix nick pokemon]
  array.each do |row|
    puts "generating QR code for: #{row.to_s}"
    qrcode_content = row
    if !qrcode_content.empty?
      qrcode = RQRCode::QRCode.new(row, level: :h, size: 3)
      pdf.bounding_box([10, pdf.cursor], width: 138, height: 68) do
        pdf.move_down(12)
        pdf.indent(12) do
          pdf.render_qr_code(qrcode, dot: 1.2, align: :left)
        end
        pdf.move_up(40)
        pdf.indent(70) do
          pdf.text qrcode_content
        end
        pdf.stroke_bounds
      end
      pdf.start_new_page
    end
  end
  pdf.render_file("sample.pdf")
end

generate_qr_code_and_render_in_pdf
