
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
  end

  def code
    require "rqrcode"
    @qr_code = RQRCode::QRCode.new("https://instagram.com/danielasalcedo22?igshid=NDc0ODY0MjQ=")
    @svg = @qr_code.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    )
  end
end
