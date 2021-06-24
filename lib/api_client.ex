defmodule MovieMatch.API do

  def http_get(url) do
    HTTPoison.get(url, [], follow_redirect: true) 
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

  def get(url) do
    url
    |> http_get()
    |> process_response()
  end  
end 
