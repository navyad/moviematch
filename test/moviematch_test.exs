defmodule MOVIEMATCHTest do
  use ExUnit.Case
  doctest MOVIEMATCH

  test "convert json string to map" do
    input = "{\"name\":\"Devin Torres\",\"age\":27}"
    expected = %{"age" => 27, "name" => "Devin Torres"}
    assert MOVIEMATCH.movie_map(input) == expected
  end

  test "movie_id_titles with all keys" do
    input = %{"titles" => %{"movie-id"=> %{"primary"=> %{"title"=> "movie-title"}}}}
    expected =[%{"movie-id" => "movie-title"}]
    assert MOVIEMATCH.movie_id_titles(input) == expected
  end

  test "missing key titles" do
    input = %{"missing-titles" => %{"movie-id"=> %{"primary"=> %{"title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> MOVIEMATCH.movie_id_titles(input) end
  end

  test "missing primary key" do
    input = %{"titles" => %{"movie-id"=> %{"missing-primary"=> %{"title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> MOVIEMATCH.movie_id_titles(input) end
  end

  test "missing title key" do
    input = %{"titles" => %{"movie-id"=> %{"primary"=> %{"missing-title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> MOVIEMATCH.movie_id_titles(input) end
  end

end
