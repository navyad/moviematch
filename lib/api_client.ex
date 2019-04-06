defmodule MovieMatch.API do

  def http_get(url, params) do
    HTTPoison.get(url, [], params: params) 
  end  

  def process_response(
    {:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
      body 
  end

  def process_response(
    {:ok, %HTTPoison.Response{status_code: 404, body: body}}) do
      body 
  end

  def process_response(
    {:error, %HTTPoison.Error{reason: reason}}) do
      {:error, reason}  
  end

  def get(url, params \\ Map.new()) do
    url
    |> http_get(params)
    |> process_response()
  end  
end 
