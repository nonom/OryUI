
foldstart // OryUITextfield Component (Updated 22/02/2019)

type typeOryUITextfield
	id as integer
	editBox as integer
	inputType$ as string
	labelText$ as string
	maxLength as integer
	pressed as integer
	sprActivationIndicator as integer
	sprContainer as integer
	sprInvisibleCover as integer
	sprLeadingIcon as integer
	sprTrailingIcon as integer
	strokeColor# as float[4]
	textfieldType$ as string
	textInput$ as string
	tweenActivationIndicator as integer
	tweenEditBox as integer
	tweenLabel as integer
	txtHelper as integer
	txtInput as integer
	txtLabel as integer
endtype

global OryUITextfieldCollection as typeOryUITextfield[]
OryUITextfieldCollection.length = 1
global OryUITextfieldIDFocused as integer : OryUITextfieldIDFocused = -1

function OryUIAnyTextfieldFocused()
	local oryUIAnyTextfieldFocused
	if (OryUITextfieldIDFocused >= 0) then oryUIAnyTextfieldFocused = 1
endfunction oryUIAnyTextfieldFocused

function OryUICreateTextfield(oryUIComponentParameters$ as string)
	local oryUITextfieldID as integer
	OryUITextfieldCollection.length = OryUITextfieldCollection.length + 1
	oryUITextfieldID = OryUITextfieldCollection.length
	OryUITextfieldCollection[oryUITextfieldID].id = oryUITextfieldID

	// DEFAULT SETTINGS
	OryUITextfieldCollection[oryUITextfieldID].strokeColor#[1] = 101
	OryUITextfieldCollection[oryUITextfieldID].strokeColor#[2] = 28
	OryUITextfieldCollection[oryUITextfieldID].strokeColor#[3] = 228
	OryUITextfieldCollection[oryUITextfieldID].strokeColor#[4] = 255

	OryUITextfieldCollection[oryUITextfieldID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprContainer, 78, 7.3) // 5.8 without label
	SetSpriteColor(OryUITextfieldCollection[oryUITextfieldID].sprContainer, 232, 232, 232, 255)
	SetSpriteOffset(OryUITextfieldCollection[oryUITextfieldID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprContainer, 0, 0)

	OryUITextfieldCollection[oryUITextfieldID].editBox = CreateEditBox()
	SetEditBoxBackgroundColor(OryUITextfieldCollection[oryUITextfieldID].editBox, 232, 232, 232, 255)
	SetEditBoxBorderSize(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
	SetEditBoxCursorColor(OryUITextfieldCollection[oryUITextfieldID].editBox, 0, 0, 0)
	SetEditBoxUseAlternateInput(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
	SetEditBoxSize(OryUITextfieldCollection[oryUITextfieldID].editBox, 72, 4.4)
	SetEditBoxPosition(OryUITextfieldCollection[oryUITextfieldID].editBox, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 3, GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 2.8)
	SetEditBoxDepth(OryUITextfieldCollection[oryUITextfieldID].editBox, GetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 1)
	SetEditBoxActive(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
	
	OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator = CreateSprite(0)
	SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, 0, 0.3)
	SetSpriteColor(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, OryUITextfieldCollection[oryUITextfieldID].strokeColor#[1], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[2], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[3], 255)
	SetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, GetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 2)
	SetSpriteOffset(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, 0, 0)
	SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer), (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer)) - 0.3)

	OryUITextfieldCollection[oryUITextfieldID].tweenActivationIndicator = CreateTweenSprite(0.2)

	OryUITextfieldCollection[oryUITextfieldID].txtLabel = CreateText("Placeholder")
	SetTextSize(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 3.6)
	SetTextColor(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 0, 0, 0, 140)
	SetTextAlignment(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 0)
	SetTextDepth(OryUITextfieldCollection[oryUITextfieldID].txtLabel, GetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 2)
	SetTextPosition(OryUITextfieldCollection[oryUITextfieldID].txtLabel, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 3.4, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - (GetTextTotalHeight(OryUITextfieldCollection[oryUITextfieldID].txtLabel) / 2))

	OryUITextfieldCollection[oryUITextfieldID].tweenLabel = CreateTweenText(0.2)

	OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover = CreateSprite(0)
	SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, 78, 7.3) // 5.8 without label
	SetSpriteColor(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, 0, 0, 0, 0)
	SetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, GetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 2)
	SetSpriteOffset(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, 0, 0)
	SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, 0, 0)
	
	if (oryUIComponentParameters$ <> "") then OryUIUpdateTextfield(oryUITextfieldID, oryUIComponentParameters$)
endfunction oryUITextfieldID

function OryUIDeleteTextfield(oryUITextfieldID as integer)
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		DeleteSprite(OryUITextfieldCollection[oryUITextfieldID].sprContainer)
		DeleteEditBox(OryUITextfieldCollection[oryUITextfieldID].editBox)
		DeleteSprite(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator)
		DeleteText(OryUITextfieldCollection[oryUITextfieldID].txtLabel)
		DeleteSprite(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover)
	endif
endfunction

function OryUIGetTextfieldHeight(oryUITextfieldID as integer)
	local oryUITextfieldHeight#
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		if (GetSpriteExists(OryUITextfieldCollection[oryUITextfieldID].sprContainer))
			oryUITextfieldHeight# = GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer)
		endif
	endif
endfunction oryUITextfieldHeight#

function OryUIGetTextfieldString(oryUITextfieldID as integer)
	local oryUITextfieldString$
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		if (GetSpriteExists(OryUITextfieldCollection[oryUITextfieldID].sprContainer))
			oryUITextfieldString$ = GetEditBoxText(OryUITextfieldCollection[oryUITextfieldID].editBox)
		endif
	endif
endfunction oryUITextfieldString$

function OryUIGetTextfieldWidth(oryUITextfieldID as integer)
	local oryUITextfieldWidth#
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		if (GetSpriteExists(OryUITextfieldCollection[oryUITextfieldID].sprContainer))
			oryUITextfieldWidth# = GetSpriteWidth(OryUITextfieldCollection[oryUITextfieldID].sprContainer)
		endif
	endif
endfunction oryUITextfieldWidth#

function OryUIInsertTextfieldListener(oryUITextfieldID as integer)
	//local oryUITextfieldSprite as integer
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		if (GetSpriteExists(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover))
			if (GetPointerReleased())
				if (OryUIGetDraggingVertically() = 0)
					if (oryUISpriteHit = OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover)
						SetEditBoxActive(OryUITextfieldCollection[oryUITextfieldID].editBox, 1)
						SetEditBoxFocus(OryUITextfieldCollection[oryUITextfieldID].editBox, 1)
					else
						SetEditBoxActive(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
						SetEditBoxFocus(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
					endif
				endif
			endif
		endif
		if (GetEditBoxExists(OryUITextfieldCollection[oryUITextfieldID].editBox))
			if (GetEditBoxHasFocus(OryUITextfieldCollection[oryUITextfieldID].editBox))
				//if (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 10.63 > 0)
				//	SetViewOffset(GetViewOffsetX(), GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 10.63)
				//endif
				OryUITextfieldIDFocused = oryUITextfieldID
				SetTextSize(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 2.4)
				SetTextY(OryUITextfieldCollection[oryUITextfieldID].txtLabel, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - 2.4 - 0.3)
				SetTextColor(OryUITextfieldCollection[oryUITextfieldID].txtLabel, OryUITextfieldCollection[oryUITextfieldID].strokeColor#[1], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[2], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[3], 255)
				SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, GetSpriteWidth(OryUITextfieldCollection[oryUITextfieldID].sprContainer), GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator))
			else
				if (OryUITextfieldIDFocused = oryUITextfieldID) then OryUITextfieldIDFocused = -1
				if (GetEditBoxText(OryUITextfieldCollection[oryUITextfieldID].editBox) = "")
					SetTextSize(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 3.6)
					SetTextY(OryUITextfieldCollection[oryUITextfieldID].txtLabel, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - (3.6 / 2))
					SetTextColor(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 0, 0, 0, 140)
					SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, 0, GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator))
				else
					SetTextSize(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 2.4)
					SetTextY(OryUITextfieldCollection[oryUITextfieldID].txtLabel, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - 2.4 - 0.3)
					SetTextColor(OryUITextfieldCollection[oryUITextfieldID].txtLabel, OryUITextfieldCollection[oryUITextfieldID].strokeColor#[1], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[2], OryUITextfieldCollection[oryUITextfieldID].strokeColor#[3], 255)
					SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, 0, GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator))
				endif
				SetEditBoxActive(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
			endif
		endif
	endif
endfunction	

function OryUIUpdateTextfield(oryUITextfieldID as integer, oryUIComponentParameters$ as string)
	OryUISetParametersType(oryUIComponentParameters$)
	
	if (oryUITextfieldID <= OryUITextfieldCollection.length)
		if (GetEditBoxExists(OryUITextfieldCollection[oryUITextfieldID].editBox))

			// IMPORTANT PARAMETERS FIRST WHICH AFFECT THE SIZE, OFFSET, AND POSITION OF THE COMPONENT
			if (OryUIParameters.size#[1] > -999999 or OryUIParameters.size#[2] > -999999)
				SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprContainer, OryUIParameters.size#[1], GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer))
				SetEditBoxSize(OryUITextfieldCollection[oryUITextfieldID].editBox, GetSpriteWidth(OryUITextfieldCollection[oryUITextfieldID].sprContainer) - 6, GetEditBoxHeight(OryUITextfieldCollection[oryUITextfieldID].editBox))
				SetSpriteSize(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, OryUIParameters.size#[1], GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer))
			endif
			if (OryUIParameters.position#[1] > -999999 or OryUIParameters.position#[2] > -999999)
				SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprContainer, OryUIParameters.position#[1], OryUIParameters.position#[2])
				SetEditBoxPosition(OryUITextfieldCollection[oryUITextfieldID].editBox, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 3, GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 2.8)
				SetTextPosition(OryUITextfieldCollection[oryUITextfieldID].txtLabel, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + 3.4, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - (GetTextTotalHeight(OryUITextfieldCollection[oryUITextfieldID].txtLabel) / 2))
				SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, GetSpriteX(OryUITextfieldCollection[oryUITextfieldID].sprContainer), (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer)) - 0.3)
				SetSpritePositionByOffset(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, OryUIParameters.position#[1], OryUIParameters.position#[2])
			endif

			// THE REST OF THE PARAMETERS NEXT
			if (OryUIParameters.backgroundColor#[1] > -999999 or OryUIParameters.backgroundColor#[2] > -999999 or OryUIParameters.backgroundColor#[3] > -999999 or OryUIParameters.backgroundColor#[4] > -999999)
				SetSpriteColor(OryUITextfieldCollection[oryUITextfieldID].sprContainer, OryUIParameters.backgroundColor#[1], OryUIParameters.backgroundColor#[2], OryUIParameters.backgroundColor#[3], OryUIParameters.backgroundColor#[4])
				SetEditBoxBackgroundColor(OryUITextfieldCollection[oryUITextfieldID].editBox, OryUIParameters.backgroundColor#[1], OryUIParameters.backgroundColor#[2], OryUIParameters.backgroundColor#[3], OryUIParameters.backgroundColor#[4])
			endif
			if (OryUIParameters.depth > -999999)
				SetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprContainer, OryUIParameters.depth)
				SetEditBoxDepth(OryUITextfieldCollection[oryUITextfieldID].editBox, OryUIParameters.depth - 1)
				SetTextDepth(OryUITextfieldCollection[oryUITextfieldID].txtLabel, OryUIParameters.depth - 2)
				SetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, OryUIParameters.depth - 2)
				SetSpriteDepth(OryUITextfieldCollection[oryUITextfieldID].sprInvisibleCover, OryUIParameters.depth - 2)
			endif
			if (OryUIParameters.inputText$ <> "")
				if (GetEditBoxHasFocus(OryUITextfieldCollection[oryUITextfieldID].editBox) = 0 and GetEditBoxText(OryUITextfieldCollection[oryUITextfieldID].editBox) = "")
					SetEditBoxText(OryUITextfieldCollection[oryUITextfieldID].editBox, OryUIParameters.inputText$)
					SetTextSize(OryUITextfieldCollection[oryUITextfieldID].txtLabel, 2.4)
					SetTextY(OryUITextfieldCollection[oryUITextfieldID].txtLabel, (GetSpriteY(OryUITextfieldCollection[oryUITextfieldID].sprContainer) + (GetSpriteHeight(OryUITextfieldCollection[oryUITextfieldID].sprContainer) / 2)) - 2.4 - 0.3)
				endif
			endif
			if (OryUIParameters.inputType$ <> "")
				if (OryUIParameters.inputType$ = "integer" or OryUIParameters.inputType$ = "int")
					SetEditBoxInputType(OryUITextfieldCollection[oryUITextfieldID].editBox, 1)
				elseif (OryUIParameters.inputType$ = "string" or OryUIParameters.inputType$ = "str")
					SetEditBoxInputType(OryUITextfieldCollection[oryUITextfieldID].editBox, 0)
				endif
			endif
			if (OryUIParameters.labelText$ <> "")
				SetTextString(OryUITextfieldCollection[oryUITextfieldID].txtLabel, OryUIParameters.labelText$)
			endif
			if (OryUIParameters.maxLength > 0)
				OryUITextfieldCollection[oryUITextfieldID].maxLength = OryUIParameters.maxLength
				SetEditBoxMaxChars(OryUITextfieldCollection[oryUITextfieldID].editBox, OryUITextfieldCollection[oryUITextfieldID].maxLength)
			endif
			if (OryUIParameters.strokeColor#[1] > -999999 or OryUIParameters.strokeColor#[2] > -999999 or OryUIParameters.strokeColor#[3] > -999999)
				OryUITextfieldCollection[oryUITextfieldID].strokeColor#[1] = OryUIParameters.strokeColor#[1]
				OryUITextfieldCollection[oryUITextfieldID].strokeColor#[2] = OryUIParameters.strokeColor#[2]
				OryUITextfieldCollection[oryUITextfieldID].strokeColor#[3] = OryUIParameters.strokeColor#[3]
				OryUITextfieldCollection[oryUITextfieldID].strokeColor#[4] = OryUIParameters.strokeColor#[4]
				if (GetEditBoxText(OryUITextfieldCollection[oryUITextfieldID].editBox) <> "")
					SetTextColor(OryUITextfieldCollection[oryUITextfieldID].txtLabel, OryUIParameters.strokeColor#[1], OryUIParameters.strokeColor#[2], OryUIParameters.strokeColor#[3], OryUIParameters.strokeColor#[4])
				endif
				SetSpriteColor(OryUITextfieldCollection[oryUITextfieldID].sprActivationIndicator, OryUIParameters.strokeColor#[1], OryUIParameters.strokeColor#[2], OryUIParameters.strokeColor#[3], OryUIParameters.strokeColor#[4])
			endif
		endif
	endif
endfunction

foldend