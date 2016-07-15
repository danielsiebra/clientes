class ClientesController < ApplicationController
	require 'csv'
	def self.index

	end

	def buscar
		arquivo = params[:clientes][:nome_arquivo].tempfile
		upload = CSV.table(arquivo, :col_sep => ';')

		upload.each do |row|
			if !row.fetch(:nome).nil? && !row.fetch(:telefone).nil? && !row.fetch(:endereco).nil? && row.fetch(:cep).gsub(/\W\s?/,"").length == 8 && !row.fetch(:valor).nil? && !row.fetch(:vencimento).nil?
				cli = Cliente.create(
					nome: row.fetch(:nome),
					telefone: row.fetch(:telefone),
					endereco: row.fetch(:endereco),
					cep: row.fetch(:cep),
					valor: row.fetch(:valor),
					vencimento: row.fetch(:vencimento),
					ativo: true)
			else
				cli = Cliente.create(
					nome: row.fetch(:nome),
					telefone: row.fetch(:telefone),
					endereco: row.fetch(:endereco),
					cep: row.fetch(:cep),
					valor: row.fetch(:valor),
					vencimento: row.fetch(:vencimento),
					ativo: false)
			end
		end
	end



end
