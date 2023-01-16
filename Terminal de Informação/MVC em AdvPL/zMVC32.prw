//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

Static lEmExecucao   := .F.

/*/{Protheus.doc} User Function zMVC32
Exemplo de tela com 2 browses de cadastro usando FWBrwRelation
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC32()
	Local aArea   := GetArea()
    Local cFunBkp := FunName()
	Local aCoors  := FWGetDialogSize( oMainWnd )
	Local cIdArtist
	Local cIdCds
	Local oPanelUp
	Local oTela
	Local oPanelDown
	Local oRelaction

	//Tratativa para impedir que seja aberta a mesma janela por cima da original do browse
	If ! lEmExecucao
		SetFunName("zMVC32")
		DbSelectArea("ZD1")
		DbSelectArea("ZD2")

		//Cria a janela principal
		Define MsDialog oDlgPrinc Title "Artistas x CDs" From aCoors[1], aCoors[2] To aCoors[3], aCoors[4] OF oMainWnd Pixel

			//Divide a tela em dois containers, um de 30% e outro de 68%
			oTela     := FWFormContainer():New( oDlgPrinc )
			cIdArtist := oTela:CreateHorizontalBox( 30 )
			cIdCds    := oTela:CreateHorizontalBox( 68 )
			oTela:Activate( oDlgPrinc, .F. )

			//Cria os painéis
			oPanelUp  	:= oTela:GetPanel( cIdArtist )
			oPanelDown  := oTela:GetPanel( cIdCds )

			//Cria o browse superior trazendo dados da ZD1
			oBrowseUp:= FWmBrowse():New()
			oBrowseUp:SetOwner(oPanelUp)
			oBrowseUp:SetDescription("Artistas")
			oBrowseUp:SetAlias('ZD1')
			oBrowseUp:DisableDetails()
			oBrowseUp:SetProfileID('1')
			oBrowseUp:ExecuteFilter(.T.)
			oBrowseUp:SetMainProc("zMVC02")
			oBrowseUp:ForceQuitButton()
			oBrowseUp:SetCacheView (.F.)
			oBrowseUp:SetOnlyFields({'ZD1_CODIGO', 'ZD1_NOME'})
			oBrowseUp:Activate()

			//Cria o browse inferior, que irá trazer todos os cds do artista
			aRotina := u_z02Menu()
			oBrowseDwn:= FWMBrowse():New()
			oBrowseDwn:SetOwner(oPanelDown)
			oBrowseDwn:SetDescription("CDs de Músicas")
			oBrowseDwn:SetMenuDef('zMVC02')
			oBrowseDwn:DisableDetails()
			oBrowseDwn:SetAlias('ZD2')
			oBrowseDwn:SetProfileID('2')
			oBrowseDwn:SetMainProc("zMVC01")
			oBrowseDwn:SetCacheView (.F.)
			oBrowseDwn:SetOnlyFields({'ZD2_CD', 'ZD2_NOMECD'})

			//Faz o relacionamento entre os dois browses
			oRelaction:= FWBrwRelation():New()
			oRelaction:AddRelation( oBrowseUp  , oBrowseDwn , { { 'ZD2_ARTIST' , 'ZD1_CODIGO' } } )
			oRelaction:Activate()
			oBrowseDwn:Activate()

			//Atualiza os browses e cria a janela na tela
			oBrowseUp:Refresh()
			oBrowseDwn:Refresh()
			lEmExecucao := .T.
		Activate MsDialog oDlgPrinc Center

		lEmExecucao := .F.
        SetFunName(cFunBkp)
	EndIf

	RestArea(aArea)
Return

Static Function MenuDef()
	Local aRotina := u_z01Menu()
Return aRotina
