//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC24
Função de exemplo para demonstrar a criação de backup da onde estava nas linhas e voltando a posição
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC24()
    Local aArea := FWGetArea()
    Local aSaveLines := FWSaveRows()
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')

    //Adicionando uma linha
    oModelGrid:AddLine()

    FWRestRows(aSaveLines)
    FWRestArea(aArea)
Return
