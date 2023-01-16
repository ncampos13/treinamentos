//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC18
Função de exemplo para adicionar uma linha na grid
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC18()
    Local aArea := FWGetArea()
    //Pegando a visualização da tela
    //Local oView := FWViewActive()
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')

    //Adicionando uma linha
    oModelGrid:AddLine()

    //Atualiza a view
    //oView:Refresh()

    FWRestArea(aArea)
Return
