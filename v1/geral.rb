require "csv"
require 'fileutils'

FileUtils.rm_rf Dir.glob("Geral/*")

filepaths = %w[alagoas catimbau ceara inaja]

frase = []

filepaths.each do |filepath|
    CSV.foreach("Dados/#{filepath}.csv", headers: :first_row) do |row|
        unidade = row['Unidade'].downcase
        povoado = row['Povoado'].downcase.tr(" ", "_")
        texto = "O povoado #{row['Povoado'].upcase} da unidade #{unidade.upcase} é atendido há #{row['Atendido ha'].upcase}
Agente: #{row['Agente'].upcase}, Secretária: #{row['Nome secretaria'].upcase}
- ESTRADA
A distância para o CT é de #{row["Distancia CT"].upcase} e a situação da estrada é #{row["Sit estrada"].upcase}
Descrição da estrada: #{row["Desc estrada"].upcase}
- CASAS
A situação das casas é #{row["Sit casas"].upcase}
Tem casas de taipa? #{row["Taipa?"].upcase} (#{row["Qtd taipa"].upcase})
As casas tem banheiro? #{row["Banheiro?"].upcase}
A situação dos móveis é #{row["Sit moveis"].upcase}
- POVOADO
Situação do esgoto: #{row["Sit esgoto"].upcase}
Abastecimento da água: #{row["Abastecimento agua"].upcase}
Outras formas de abastecimento de água: #{row["Outros abastecimento agua"].nil? ? "-" : row["Outros abastecimento agua"].upcase}
Poço artesiano: #{row["Poco artesiano?"].upcase}
Observações do poço: #{row["Outros poco"].nil? ? "-" : row["Outros poco"].upcase}
Caminhões pipa? #{row["Caminhoes pipa?"].upcase}
Caminhões pipa dos Amigos do Bem? #{row["Caminhoes pipa AB?"].upcase}
O povoado tem energia elétrica? #{row["Energia Eletrica?"].upcase}
O povoado tem internet? #{row["Internet?"].nil? ? "-" : row["Internet?"].upcase}
O povoado tem sinal de celular? #{row["Sinal celular?"].upcase == 'SIM' ? 'SIM, DAS OPERADORAS ' + row["Operadoras cel"].upcase : 'NÃO'}
O povoado tem escolas? #{row["Escola no povoado?"].upcase} #{row["Qtd escolas?"].nil? ? "-" : '(' + row["Qtd escolas?"].upcase + ')'} #{row["Turmas escola"].nil? ? "-" : 'Obs: ' + row["Turmas escola"].upcase}
Situação da escola: #{row["Escola no povoado?"].upcase != "SIM" || row["Situacao escola"].nil? ? "-" : row["Situacao escola"].upcase}
Demandas da escola: #{row["Escola no povoado?"].upcase != "SIM" || row["Demanda escola"].nil? ? "-" : row["Demanda escola"].upcase}
Há ação de jovens? #{row['Acao jovens?'].upcase}
Há crianças atendidas no CT? #{row['Criancas atendidas CT?'].upcase}
Os jovens do povoado vão ao CT? #{row['jovens vao ao CT?'].nil? ? 'NÃO RESPONDIDO' : row['jovens vao ao CT?'].upcase}
Os ônibus dos Amigos do bem atendem ao povoado? Ou o povo precisa se deslocar até outro povoado? #{row['Onibus AB atendem o povoado? ou precisam se deslocar ate outro povoado?'].nil? ? "-" : row['Onibus AB atendem o povoado? ou precisam se deslocar ate outro povoado?'].upcase} #{row['No caso de deslocamento ate outro povoado, qual a distancia?'].nil? ? "-" : '(' + row['No caso de deslocamento ate outro povoado, qual a distancia?'].upcase + ')'}
Esses ônibus estão em qual situação? #{row['Sit onibus AB'].nil? ? "-" : row['Sit onibus AB'].upcase}
Há monitores para acompanhar nesses ônibus? #{row['Monitor no onibus AB?'].nil? || row['Monitor no onibus AB?'].upcase != 'SIM' ? 'NÃO' : row['Monitor no onibus AB?'].upcase + '. Nome do monitor:' + row["Nome monitor onibus"].upcase}
Como é feito o deslocamento extra? #{row['Deslocamento extra feito com'].nil? ? "-" : row['Deslocamento extra feito com'].upcase}
Como é o auxílio dos Amigos do Bem no deslocamento extra? #{row['Como e o auxilio do AB no deslocamento extra'].nil? ? "-" : row['Como e o auxilio do AB no deslocamento extra'].upcase}
Qual a principal fonte de renda do povoado? #{row['Principal fonte de renda'].upcase}
Participam do projeto Mudas Amigos do Bem? #{row['Participam Projeto Mudas Amigos do Bem?'].upcase}
Têm interesse de participar? #{row['Tem interesse participar mudas AB?'].upcase}
O povoado tem igrejas ou templos? #{row['Tem igreja?'].upcase}
Como é a religiosidade do povoado? #{row['religiosidade'].upcase}
Ocorrem palestras do Projeto Transformacao? #{row['Palestras do Projeto Transformacao?'].upcase}
Realizam Projeto transformacao com outros povoados? #{row['Projeto transformacao com outros povoados?'].upcase}
Realizam Projeto transformacao com outros povoados? #{row['Projeto transformacao com outros povoados?'].upcase}
Quais? #{row['Caso seja realizado em conjunto coloque aqui o nome dos outros povoados'].nil? ? "-" : row["Caso seja realizado em conjunto coloque aqui o nome dos outros povoados"].upcase}
Qual o local onde ocorre o Projeto transformação? #{row['local Projeto Transformacao'].upcase} #{row['Outros local Projeto transformacao'].nil? ? "-" : ' ou ' + row['Outros local Projeto transformacao'].upcase}
Qual a infraestrutura do local do Projeto transformação? #{row['local Projeto Transformacao'].upcase}
Qual a quantidade de pessoas que participam do Projeto transformação? #{row['Qtd pessoas projeto transformacao?'].upcase}
O local é adequado para o Projeto transformação? #{row['local adequado projeto transformacao?'].upcase}
Há a necessidade de construção de um Espaço do Bem? #{row['necessidade de construcao Espaco do Bem?'].upcase}
Em qual local? #{row['local identificado de construcao'].nil? ? "-" : row["local identificado de construcao"].upcase}
Há a necessidade de containers? #{row['necessidade container?'].upcase}
Em qual local? #{row['local containers'].nil? ? "-" : row["local containers"].upcase}
A ficha de dados do container foi preenchida? #{row['ficha de dados do container preenchida?'].nil? ? "-" : row["ficha de dados do container preenchida?"].upcase}
Existe algum bar no povoado? #{row['bar?'].upcase}
Quantos? #{row['Qtd bares'].nil? ? "-" : row["Qtd bares"].upcase}
Há festas com bebida? #{row['Festas com bebida?'].upcase}
Como são as festas? #{row['tipo festa'].nil? ? "-" : row["tipo festa"].upcase}
Há quantos casos de alcoolismo? #{row['Alcoolismo?'].upcase}
É realizado o Projeto Vitória? #{row['Projeto Vitoria?'].upcase}
Com qual frequência? #{row['Freq proj vitoria'].nil? ? "-" : row["Freq proj vitoria"].upcase}
Com qual frequência a equipe de São Paulo auxilia no Projeto Vitória? #{row['freq sp projeto vitoria'].nil? ? "-" : row["freq sp projeto vitoria"].upcase}
Qual o local do Projeto Vitória? #{row['local Projeto Vitoria'].nil? ? "-" : row["local Projeto Vitoria"].upcase}
Observações adicionais do Projeto Vitória? #{row['obs Projetos Vitoria'].nil? ? "-" : row["obs Projetos Vitoria"].upcase}
Há trabalhadores dos Amigos do Bem? #{row["trabalhadores ab?"].upcase}
Onde eles atuam? #{row['Onde atuam?'].nil? ? "-" : row["Onde atuam?"].upcase}
Há voluntários dos Amigos do Bem? #{row["voluntarios ab?"].upcase}
Qual a quantidade de voluntário dos Amigos do Bem? #{row['qtd voluntarios ab'].nil? ? "-" : row["qtd voluntarios ab"].upcase}
Qual a frequência do voluntariado dos Amigos do Bem? #{row['frequencia voluntariado'].nil? ? "-" : row["frequencia voluntariado"].upcase}
Há posto de saúde ou hospital no povoado? #{row["posto de saude ou hospital?"].upcase}
Qual a distância e tempo de chegada se o posto for na sede do município? #{row['distancia e tempo para chegar se posto for na sede do municipio'].nil? ? "-" : row["distancia e tempo para chegar se posto for na sede do municipio"].upcase}
Há atendimento médico do SUS? #{row["atendimento medico sus?"].upcase}
Há atendimento médico dos Amigos do Bem? #{row["atendimento medico AB?"].upcase}
Há a necessidade de médicos, dentistas ou oftalmos dos Amigos do Bem? #{row["necessidade Medicos-Dentistas-Oftalmo AB?"].upcase}
Qual a frequência de atendimento de médicos no povoado? #{row["freq medicos"].upcase}
Há atendimendo de dentistas do SUS no povoado? #{row["atendimento Dentistas do SUS?"].upcase}
Há atendimendo de dentistas do SUS no povoado? #{row["atendimento Dentistas do SUS?"].upcase}
Qual a frequência de atendimento de dentistas no povoado? #{row["freq dentistas"].upcase}
O povoado já teve Grupo Visão? #{row["ja teve Grupo Visao?"].upcase}
Quantos moradores comparecem nas consultas dos Amigos do Bem? #{row['qtd moradores atendimento consultas ab'].nil? ? "-" : row["qtd moradores atendimento consultas ab"].upcase}
Há acesso a energia elétrica trifásica para caminhões da saúde? #{row["energia eletrica trifasica"].upcase}
Há acesso de remédios local no povoado? #{row["acesso a remedios local?"].upcase}
Quais as doenças mais frequentes do povoado? #{row["Doencas mais frequentes?"].upcase}
Há deficiência física ou mental no povoado? #{row["deficiencia fisica ou mental?"].upcase}
Observações gerais: #{row['obs gerais'].nil? ? "-" : row["obs gerais"].upcase}"
        File.open("Geral/#{unidade}.txt", "a") do |txt|
            txt << texto + "\n" * 3
        end
    end
    
end
