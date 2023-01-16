//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC26
Função de exemplo para mostrar o tamanho total da grid
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC26()
    Local aArea  := FWGetArea()
    Local nTamanho := 0
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')
    
    //Busca o tamanho total e exibe uma mensagem
    nTamanho := oModelGrid:Length()
    FWAlertInfo("A quantidade de linhas que foram inseridas na grid é de [" + cValToChar(nTamanho) + "] registros.", "Tamanho da Grid")

    FWRestArea(aArea)
Return
