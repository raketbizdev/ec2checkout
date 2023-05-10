class ErrorsController < ApplicationController
  def show
    status_code = params[:status_code].present? ? params[:status_code].to_i : 500
    if valid_error_code?(status_code)
      render status: status_code
    else
      render status: 500
    end
  end

  private

  def valid_error_code?(code)
    valid_codes = [
      # 4xx Client Errors
      400, 401, 402, 403, 404, 405, 406, 407, 408, 409,
      410, 411, 412, 413, 414, 415, 416, 417, 418, 421,
      422, 423, 424, 425, 426, 428, 429, 431, 451,

      # 5xx Server Errors
      500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511
    ]
    valid_codes.include?(code)
  end
end