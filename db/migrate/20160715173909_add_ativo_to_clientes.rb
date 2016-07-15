class AddAtivoToClientes < ActiveRecord::Migration
  def change
  	add_column :clientes, :ativo, :boolean
  end
end
