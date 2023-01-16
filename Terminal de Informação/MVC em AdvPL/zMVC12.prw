//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zMVC12
Fun��o para usar o ExecAuto acionando FWMVCRotAuto
@type function
@author Atilio
@since 28/02/2022
/*/

User Function zMVC12()
	Local aArea         := GetArea()
    Local aDados        := {}
    Private aRotina     := FWLoadMenuDef("zMVC01")
    Private oModel      := u_z01Model() //FWLoadModel("zMVC01")
    Private lMsErroAuto := .F.
     
    //Adicionando os dados do ExecAuto
    aAdd(aDados, {"ZD1_CODIGO",     GetSXENum("ZD1", "ZD1_CODIGO") , Nil})
    aAdd(aDados, {"ZD1_NOME",       "S� Pra Contrariar"            , Nil})
    aAdd(aDados, {"ZD1_OBSERV",     "Observa��o Teste ExecAuto 2"  , Nil})
    ConfirmSX8()
     
    //Chamando a inclus�o - Modelo 1
    lMsErroAuto := .F.
    FWMVCRotAuto( ;
        oModel,;                        //Modelo
        "ZD1",;                         //Alias
        MODEL_OPERATION_INSERT,;        //Operacao
        {{"ZD1MASTER", aDados}};        //Dados
    )

    //Se tiver mais de um Form, deve se passar dessa forma:
    // {{"ZZ2MASTER", aAutoCab}, {"ZZ3DETAIL", aAutoItens}})
     
    //Se houve erro no ExecAuto, mostra mensagem
    If lMsErroAuto
        MostraErro()
     
    //Sen�o, mostra uma mensagem de inclus�o    
    Else
        MsgInfo("Registro incluido!", "Aten��o")
    EndIf
     
    RestArea(aArea)
Return
