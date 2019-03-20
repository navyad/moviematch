defmodule MovieMatch.API do

  require Logger

  def get(url) do
    Logger.info("request: #{url}")
    HTTPoison.get(url)
  end

  def get(url, params) do
    Logger.info("request: #{url}")
    HTTPoison.get(url, [], params: params) 
  end  

  def decode_body(body) do
    Poison.decode!(body)
  end

  def process_response(response) do
    status_code  = response.status_code
    cond do
      status_code == 200 ->
        {:ok, decode_body(response.body)}
      status_code !=200 ->  
        {:error, status_code}
    end
  end
end 
