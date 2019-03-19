defmodule MovieMatch.API do

  def get(url) do
     HTTPoison.get(url)
  end

  def get(url, params) do
    HTTPoison.get(url, [], params: params) 
  end  

  def process_response(response) do
    status_code  = response.status_code
    cond do
      status_code == 200 ->
        {:success, Poison.decode!(response.body)}
      status_code !=200 ->  
        {:error, status_code}
    end  
  end  
end  
