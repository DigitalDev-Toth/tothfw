defmodule TothApp.RemoteUsers do
    use GenServer

    def start_link(opts \\ []) do
        {:ok, _pid} = GenServer.start_link(TothApp.RemoteUsers, [
            {:ets_table_name, :remote_users_table},
            {:ets_table_limit, 1000}
        ], opts)
    end

    def init(args) do
        [{:ets_table_name, ets_table_name}, {:ets_table_limit, ets_table_limit}] = args

        :ets.new(ets_table_name, [:named_table, :set, :private])

        {:ok, %{ets_table_limit: ets_table_limit, ets_table_name: ets_table_name}}
    end

    def get_users() do
        GenServer.call(:remote_users, {nil})
    end

    def new_user(key, user) do
        GenServer.call(:remote_users, {key, user})
    end

    def delete_user(key) do
        GenServer.call(:remote_users, {key, nil, nil})
    end

    def handle_call({key, user}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = new_user(key, user, ets_table_name)
        {:reply, result, state}
    end

    def handle_call({_}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = :ets.match_object(ets_table_name, :"$1")
        {:reply, result, state}
    end

    def handle_call({key, _, _}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = :ets.delete(ets_table_name, key)
        {:reply, result, state}
    end

    defp new_user(key, user, ets_table_name) do
        case :ets.member(ets_table_name, key) do
            false ->
                :ets.insert_new(ets_table_name, {key, [user]})
                {:ok, user}
            true ->
                {:ok, user}
        end
    end
end
