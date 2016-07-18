class ClientesController < ApplicationController
	require 'csv'
	def index
		
	end

	def buscar
		if !params[:clientes].nil?
			if params[:clientes][:nome_arquivo].content_type == "text/csv"
				@nome = params[:clientes][:nome_arquivo].original_filename
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
				@msg_s = "O arquivo \"#{@nome}\" foi processadocom sucesso"
			else
				@msg_f = "O arquivo nao e do tipo CSV! \nPor favor, submeta um arquivo do tipo CSV."

			end
		else
			@msg_f = "Nao foi inserido nenhum arquivo! \nPor favor, submeta um arquivo do tipo CSV"

		end	
	end

	def banco
		@ca = Cliente.where("ativo= ?", true)
		@ci = Cliente.where("ativo= ?", false)
	end

end
