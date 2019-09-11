class ApplicationController < ActionController::API
  def json_response(object, include_data: '', custom_include_data: nil, include_params: nil, meta: {}, status: :ok)
    render_data = {
      json: object,
      include: include_data,
      include_params: custom_include_data || include_params,
      status: status,
      meta: meta,
      adapter: :json
    }

    render(render_data)
  end
end
