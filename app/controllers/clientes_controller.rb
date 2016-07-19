class ClientesController < ApplicationController
	require 'csv'
	require 'prawn'
	require 'prawn/table'
	def index

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

	def banco
		@ca = Cliente.where("ativo= ?", true)
		@ci = Cliente.where("ativo= ?", false)
	end

	def gerar
		Prawn::Document.generate("#{Rails.root}/app/assets/images/tabela.pdf") do |pdf|
			clientes = Cliente.limit(8).each do |cliente|
				pdf.table  ([
					 ["#{cliente.nome}\n", 
					 "#{cliente.telefone}\n",
				   "#{cliente.endereco}\n",
				   "#{cliente.cep}\n",
				   "#{cliente.valor}\n",
				   "#{cliente.vencimento}\n"]
				 	])
			end
    end	
	end
end
