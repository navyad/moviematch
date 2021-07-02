defmodule RequestError do
  defexception [:message]

  @impl true
  def exception(error_map) do
    %RequestError{message: error_map}
  end
end


defmodule MovieMatch.API do
  
  require Logger

  def http_get(url) do
    Logger.info "making request #{url}"
    HTTPoison.get(url, [], follow_redirect: true) 
  end  

  def process_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
      body 
  end

  def process_response({:ok, %HTTPoison.Response{status_code: 404, body: body}}) do
      body 
  end

  def process_response({:error, %HTTPoison.Error{reason: reason}}) do
      raise RequestError, {:error, reason}
  end

  def get(url) do
    url
    |> http_get()
    |> process_response()
  end  
end 
