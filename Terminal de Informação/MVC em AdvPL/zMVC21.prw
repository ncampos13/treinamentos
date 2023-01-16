//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC21
Função de exemplo para limpar os dados da grid
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC21()
    Local aArea := FWGetArea()
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')

    //Limpando a grid
    If oModelGrid:CanClearData()
        oModelGrid:ClearData()
    EndIf

    FWRestArea(aArea)
Return
