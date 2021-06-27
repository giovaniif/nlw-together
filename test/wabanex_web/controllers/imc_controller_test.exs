defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, return the IMC info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_result = %{"result" => %{"Dani" => 23.437499999999996, "Diego" => 23.04002019946976, "Gabul" => 22.857142857142858, "Rafael" => 24.897060231734173, "Rodrigo" => 26.234567901234566}}

      assert expected_result == response
    end

    test "when there are invalid params, returnn an error", %{conn: conn} do
      params = %{"filename" => "invalid_file.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_result = %{"result" => "Error while opening the file"}

      assert expected_result == response
    end
  end
end
