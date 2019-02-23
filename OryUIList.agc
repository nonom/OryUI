
foldstart // OryUIList Component (Updated 23/02/2019)

type typeOryUIList
	id as integer
	itemID as integer[]
	itemSize# as float[2]
	noOfLeftLines as integer
	noOfRightLines as integer
	rightIconType$ as string
	showLeftThumbnail as integer
	showRightIcon as integer
	sprContainer as integer
	sprItemContainer as integer[]
	sprItemDivider as integer[]
	sprItemLeftThumbnail as integer[]
	sprItemRightIcon as integer[]
	txtItemLeftLine1 as integer[]
	txtItemLeftLine2 as integer[]
	txtItemRightLine1 as integer[]
	txtItemRightLine2 as integer[]
endtype

global OryUIListCollection as typeOryUIList[]
OryUIListCollection.length = 1

function OryUICreateList(oryUIComponentParameters$ as string)
	local oryUIListID as integer
	OryUIListCollection.length = OryUIListCollection.length + 1
	oryUIListID = OryUIListCollection.length
	OryUIListCollection[oryUIListID].id = oryUIListID

	// DEFAULT SETTINGS
	OryUIListCollection[oryUIListID].itemSize#[1] = 100
	OryUIListCollection[oryUIListID].itemSize#[2] = 7
	OryUIListCollection[oryUIListID].noOfLeftLines = 1
	OryUIListCollection[oryUIListID].noOfRightLines = 0
	OryUIListCollection[oryUIListID].showLeftThumbnail = 0
	OryUIListCollection[oryUIListID].showRightIcon = 0

	OryUIListCollection[oryUIListID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUIListCollection[oryUIListID].sprContainer, OryUIListCollection[oryUIListID].itemSize#[1], 0)
	SetSpriteColor(OryUIListCollection[oryUIListID].sprContainer, 204, 204, 204, 255)
	SetSpriteOffset(OryUIListCollection[oryUIListID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprContainer, 0, 0)

	if (oryUIComponentParameters$ <> "") then OryUIUpdateList(oryUIListID, oryUIComponentParameters$)
endfunction oryUIListID

function OryUIDeleteList(oryUIListID as integer)
	DeleteSprite(OryUIListCollection[oryUIListID].sprContainer)
	while (OryUIListCollection[oryUIListID].itemID.length > 0)
		OryUIDeleteListItem(oryUIListID, 0)
	endwhile
endfunction

function OryUIDeleteListItem(oryUIListID as integer, oryUIListItemID as integer)
	DeleteSprite(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID])
	DeleteSprite(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID])
	DeleteSprite(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID])
	DeleteSprite(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID])
	DeleteText(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID])
	DeleteText(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID])
	DeleteText(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID])
	DeleteText(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID])
	OryUIListCollection[oryUIListID].itemID.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].sprItemContainer.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].sprItemDivider.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].sprItemLeftThumbnail.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].sprItemRightIcon.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].txtItemLeftLine1.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].txtItemLeftLine2.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].txtItemRightLine1.remove(oryUIListItemID)
	OryUIListCollection[oryUIListID].txtItemRightLine2.remove(oryUIListItemID)
endfunction

function OryUIGetListHeight(oryUIListID as integer)
	local oryUIListEndY#
	local oryUIListHeight#
	local oryUIListStartY#
	oryUIListStartY# = GetSpriteY(OryUIListCollection[oryUIListID].sprContainer)
	for oryUIForI = OryUIGetListItemCount(oryUIListID) to 0 step -1
		if (GetSpriteExists(OryUIListCollection[oryUIListID].sprItemContainer[oryUIForI]))
			oryUIListEndY# = GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIForI]) + GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIForI])
			exit
		endif
	next
	oryUIListHeight# = oryUIListEndY# - oryUIListStartY#
endfunction oryUIListHeight#

function OryUIGetListItemCount(oryUIListID as integer)
	local oryUIListItemCount
	oryUIListItemCount = OryUIListCollection[oryUIListID].itemID.length
endfunction oryUIListItemCount

function OryUIInsertListItem(oryUIListID as integer, oryUIListIndex as integer, oryUIComponentParameters$ as string)
	if (oryUIListIndex = -1)
		OryUIListCollection[oryUIListID].itemID.length = OryUIListCollection[oryUIListID].itemID.length + 1
		OryUIListCollection[oryUIListID].sprItemContainer.length = OryUIListCollection[oryUIListID].sprItemContainer.length + 1
		OryUIListCollection[oryUIListID].sprItemDivider.length = OryUIListCollection[oryUIListID].sprItemDivider.length + 1
		OryUIListCollection[oryUIListID].sprItemLeftThumbnail.length = OryUIListCollection[oryUIListID].sprItemLeftThumbnail.length + 1
		OryUIListCollection[oryUIListID].sprItemRightIcon.length = OryUIListCollection[oryUIListID].sprItemRightIcon.length + 1
		OryUIListCollection[oryUIListID].txtItemLeftLine1.length = OryUIListCollection[oryUIListID].txtItemLeftLine1.length + 1
		OryUIListCollection[oryUIListID].txtItemLeftLine2.length = OryUIListCollection[oryUIListID].txtItemLeftLine2.length + 1
		OryUIListCollection[oryUIListID].txtItemRightLine1.length = OryUIListCollection[oryUIListID].txtItemRightLine1.length + 1
		OryUIListCollection[oryUIListID].txtItemRightLine2.length = OryUIListCollection[oryUIListID].txtItemRightLine2.length + 1
		oryUIListItemID = OryUIListCollection[oryUIListID].sprItemContainer.length
		OryUIListCollection[oryUIListID].itemID[oryUIListItemID] = oryUIListItemID
	endif

	OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID] = CreateSprite(0)
	SetSpriteSize(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], OryUIListCollection[oryUIListID].itemSize#[1], OryUIListCollection[oryUIListID].itemSize#[2])
	SetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprContainer) - 1)
	SetSpriteColor(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], 255, 255, 255, 255)
	SetSpriteOffset(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], 0, 0)
	SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], GetSpriteXByOffset(OryUIListCollection[oryUIListID].sprContainer), GetSpriteYByOffset(OryUIListCollection[oryUIListID].sprContainer) + 0.1 + (oryUIListItemID * OryUIListCollection[oryUIListID].itemSize#[2]))

	OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID] = CreateText(" ")
	SetTextSize(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], 3)
	SetTextColor(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], 0, 0, 0, 255)
	SetTextAlignment(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], 0)
	SetTextDepth(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)

	OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID] = CreateText(" ")
	SetTextSize(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], 2.6)
	SetTextColor(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], 0, 0, 0, 255)
	SetTextAlignment(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], 0)
	SetTextDepth(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)

	OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID] = CreateText(" ")
	SetTextSize(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], 3)
	SetTextColor(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], 0, 0, 0, 255)
	SetTextAlignment(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], 2)
	SetTextDepth(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)
	
	OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID] = CreateText(" ")
	SetTextSize(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], 2.6)
	SetTextColor(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], 0, 0, 0, 255)
	SetTextAlignment(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], 2)
	SetTextDepth(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)

	OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID] = CreateSprite(0)
	SetSpriteSize(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], 100, 0.1)
	SetSpriteDepth(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)
	SetSpriteColor(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], 204, 204, 204, 255)
	SetSpriteOffset(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], 0, 0.05)

	OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID] = CreateSprite(0)
	SetSpriteSize(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], -1, 4)
	SetSpriteDepth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)
	SetSpriteColor(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], 255, 255, 255, 255)
	SetSpriteOffset(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]) / 2, GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]) / 2)

	OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID] = CreateSprite(0)
	SetSpriteSize(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], -1, 3)
	SetSpriteImage(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], oryUIIconDeleteImage)
	SetSpriteDepth(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], GetSpriteDepth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) - 1)
	SetSpriteColor(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], 0, 0, 0, 255)
	SetSpriteOffset(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID]) / 2, GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID]) / 2)

	if (oryUIComponentParameters$ <> "") then OryUIUpdateListItem(oryUIListID, oryUIListItemID, oryUIComponentParameters$)
endfunction

function OryUISetListItemCount(oryUIListID as integer, oryUINewListItemCount as integer)
	local oryUIOldListItemCount
	oryUIOldListItemCount = OryUIGetListItemCount(oryUIListID)
	while (OryUIGetListItemCount(oryUIListID) > oryUINewListItemCount - 1)
		OryUIDeleteListItem(oryUIListID, OryUIGetListItemCount(oryUIListID))
	endwhile
	for oryUIForI = 0 to oryUINewListItemCount - 1
		if (oryUIForI > oryUIOldListItemCount)
			OryUIInsertListItem(oryUIListID, -1, "")
		endif
	next
endfunction

function OryUIUpdateList(oryUIListID as integer, oryUIComponentParameters$ as string)
	OryUISetParametersType(oryUIComponentParameters$)

	if (GetSpriteExists(OryUIListCollection[oryUIListID].sprContainer))
		
		// IMPORTANT PARAMETERS FIRST WHICH AFFECT THE SIZE, OFFSET, AND POSITION OF THE COMPONENT
		if (OryUIParameters.size#[1] > -999999)
			SetSpriteSize(OryUIListCollection[oryUIListID].sprContainer, OryUIParameters.size#[1], 0)
		endif
		if (OryUIParameters.position#[1] > -999999 or OryUIParameters.position#[2] > -999999)
			SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprContainer, OryUIParameters.position#[1], OryUIParameters.position#[2])
		elseif (OryUIParameters.position#[1] > -999999 or OryUIParameters.position#[2] = -999999)
			SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprContainer, OryUIParameters.position#[1], GetSpriteYByOffset(OryUIListCollection[oryUIListID].sprContainer))
		elseif (OryUIParameters.position#[1] = -999999 or OryUIParameters.position#[2] > -999999)
			SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprContainer, GetSpriteXByOffset(OryUIListCollection[oryUIListID].sprContainer), OryUIParameters.position#[2])
		endif

		// THE REST OF THE PARAMETERS NEXT
		if (OryUIParameters.depth > -999999)
			SetSpriteDepth(OryUIListCollection[oryUIListID].sprContainer, OryUIParameters.depth)
		endif
		if (OryUIParameters.itemSize#[1] > -999999 and OryUIParameters.itemSize#[2] > -999999)
			OryUIListCollection[oryUIListID].itemSize#[1] = OryUIParameters.itemSize#[1]
			OryUIListCollection[oryUIListID].itemSize#[2] = OryUIParameters.itemSize#[2]
		endif
		if (OryUIParameters.noOfLeftLines > -999999)
			OryUIListCollection[oryUIListID].noOfLeftLines = OryUIParameters.noOfLeftLines
		endif
		if (OryUIParameters.noOfRightLines > -999999)
			OryUIListCollection[oryUIListID].noOfRightLines = OryUIParameters.noOfRightLines
		endif
		if (OryUIParameters.showLeftThumbnail > -999999)
			OryUIListCollection[oryUIListID].showLeftThumbnail = OryUIParameters.showLeftThumbnail
		endif
		if (OryUIParameters.showRightIcon > -999999)
			OryUIListCollection[oryUIListID].showRightIcon = OryUIParameters.showRightIcon
		endif
	endif
endfunction

function OryUIUpdateListItem(oryUIListID as integer, oryUIListItemID as integer, oryUIComponentParameters$ as string)
	OryUISetParametersType(oryUIComponentParameters$)
	
	if (GetSpriteExists(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]))
		
		// IMPORTANT PARAMETERS FIRST WHICH AFFECT THE SIZE, OFFSET, AND POSITION OF THE COMPONENT
		if (OryUIListCollection[oryUIListID].showLeftThumbnail = 1)
			if (OryUIParameters.leftThumbnailImageID > 0)
				SetSpriteImage(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], OryUIParameters.leftThumbnailImageID)
				SetSpriteColor(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], 255, 255, 255, 255)
				SetSpriteSize(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], -1, 4)
			else
				SetSpriteImage(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], 0)
				SetSpriteColor(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], 204, 204, 204, 255)
				SetSpriteSize(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], -1, 4)
			endif
			OryUIPinSpriteToCentreLeftOfSprite(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], 2 + (GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]) / 2), 0)
		elseif (OryUIListCollection[oryUIListID].showLeftThumbnail = 0)
			SetSpriteSize(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID], 0, 0)
		endif
		if (OryUIListCollection[oryUIListID].showRightIcon = 1)
			if (lower(OryUIParameters.rightIcon$) = "delete") then SetSpriteImage(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], oryUIIconDeleteImage)
			OryUIPinSpriteToCentreRightOfSprite(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], -(2 + (GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID]) / 2)), 0)
		elseif (OryUIListCollection[oryUIListID].showLeftThumbnail = 0)
			SetSpriteSize(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], 0, 0)
		endif
		if (OryUIParameters.noOfLeftLines = 1)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), (GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0)) - (GetTextTotalHeight(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID]) / 2.0))
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], -10000, -10000)
		elseif (OryUIParameters.noOfLeftLines = 2)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), (GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0)) - GetTextTotalHeight(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID]) - 0.1)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0) + 0.1)
		elseif (OryUIListCollection[oryUIListID].noOfLeftLines = 1)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), (GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0)) - (GetTextTotalHeight(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID]) / 2.0))
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], -10000, -10000)
		elseif (OryUIListCollection[oryUIListID].noOfLeftLines = 2)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), (GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0)) - GetTextTotalHeight(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID]) - 0.1)
			SetTextPosition(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], GetSpriteX(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + 4 + GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemLeftThumbnail[oryUIListItemID]), GetSpriteY(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + (GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) / 2.0) + 0.1)
		endif

		// THE REST OF THE PARAMETERS NEXT
		if (OryUIParameters.color#[1] > -999999 or OryUIParameters.color#[2] > -999999 or OryUIParameters.color#[3] > -999999 or OryUIParameters.color#[4] > -999999)
			SetSpriteColor(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID], OryUIParameters.color#[1], OryUIParameters.color#[2], OryUIParameters.color#[3], OryUIParameters.color#[4])
		endif
		if (OryUIParameters.leftLine1Text$ <> "")
			SetTextString(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], OryUIParameters.leftLine1Text$)
		endif
		if (OryUIParameters.leftLine1TextBold > -999999)
			SetTextBold(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], OryUIParameters.leftLine1TextBold)
		endif
		if (OryUIParameters.leftLine1TextColor#[1] > -999999 or OryUIParameters.leftLine1TextColor#[2] > -999999 or OryUIParameters.leftLine1TextColor#[3] > -999999 or OryUIParameters.leftLine1TextColor#[4] > -999999)
			SetTextColor(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], OryUIParameters.leftLine1TextColor#[1], OryUIParameters.leftLine1TextColor#[2], OryUIParameters.leftLine1TextColor#[3], OryUIParameters.leftLine1TextColor#[4])
		endif
		if (OryUIParameters.leftLine1TextSize# > -999999)
			SetTextSize(OryUIListCollection[oryUIListID].txtItemLeftLine1[oryUIListItemID], OryUIParameters.leftLine1TextSize#)
		endif
		if (OryUIParameters.leftLine2Text$ <> "")
			SetTextString(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], OryUIParameters.leftLine2Text$)
		endif
		if (OryUIParameters.leftLine2TextBold > -999999)
			SetTextBold(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], OryUIParameters.leftLine2TextBold)
		endif
		if (OryUIParameters.leftLine2TextColor#[1] > -999999 or OryUIParameters.leftLine2TextColor#[2] > -999999 or OryUIParameters.leftLine2TextColor#[3] > -999999 or OryUIParameters.leftLine2TextColor#[4] > -999999)
			SetTextColor(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], OryUIParameters.leftLine2TextColor#[1], OryUIParameters.leftLine2TextColor#[2], OryUIParameters.leftLine2TextColor#[3], OryUIParameters.leftLine2TextColor#[4])
		endif
		if (OryUIParameters.leftLine2TextSize# > -999999)
			SetTextSize(OryUIListCollection[oryUIListID].txtItemLeftLine2[oryUIListItemID], OryUIParameters.leftLine2TextSize#)
		endif
		if (OryUIParameters.rightIconColor#[1] > -999999 or OryUIParameters.rightIconColor#[2] > -999999 or OryUIParameters.rightIconColor#[3] > -999999 or OryUIParameters.rightIconColor#[4] > -999999)
			SetSpriteColor(OryUIListCollection[oryUIListID].sprItemRightIcon[oryUIListItemID], OryUIParameters.rightIconColor#[1], OryUIParameters.rightIconColor#[2], OryUIParameters.rightIconColor#[3], OryUIParameters.rightIconColor#[4])
		endif
		if (OryUIParameters.rightLine1Text$ <> "")
			SetTextString(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], OryUIParameters.rightLine1Text$)
		endif
		if (OryUIParameters.rightLine1TextBold > -999999)
			SetTextBold(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], OryUIParameters.rightLine1TextBold)
		endif
		if (OryUIParameters.rightLine1TextColor#[1] > -999999 or OryUIParameters.rightLine1TextColor#[2] > -999999 or OryUIParameters.rightLine1TextColor#[3] > -999999 or OryUIParameters.rightLine1TextColor#[4] > -999999)
			SetTextColor(OryUIListCollection[oryUIListID].txtItemRightLine1[oryUIListItemID], OryUIParameters.rightLine1TextColor#[1], OryUIParameters.rightLine1TextColor#[2], OryUIParameters.rightLine1TextColor#[3], OryUIParameters.rightLine1TextColor#[4])
		endif
		if (OryUIParameters.rightLine1TextSize# > -999999)
			SetTextSize(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], OryUIParameters.rightLine1TextSize#)
		endif
		if (OryUIParameters.rightLine2Text$ <> "")
			SetTextString(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], OryUIParameters.rightLine2Text$)
		endif
		if (OryUIParameters.rightLine2TextBold > -999999)
			SetTextBold(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], OryUIParameters.rightLine2TextBold)
		endif
		if (OryUIParameters.rightLine2TextColor#[1] > -999999 or OryUIParameters.rightLine2TextColor#[2] > -999999 or OryUIParameters.rightLine2TextColor#[3] > -999999 or OryUIParameters.rightLine2TextColor#[4] > -999999)
			SetTextColor(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], OryUIParameters.rightLine2TextColor#[1], OryUIParameters.rightLine2TextColor#[2], OryUIParameters.rightLine2TextColor#[3], OryUIParameters.rightLine2TextColor#[4])
		endif
		if (OryUIParameters.rightLine2TextSize# > -999999)
			SetTextSize(OryUIListCollection[oryUIListID].txtItemRightLine2[oryUIListItemID], OryUIParameters.rightLine2TextSize#)
		endif
		SetSpriteSize(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], GetSpriteWidth(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]), 0.05)
		SetSpritePositionByOffset(OryUIListCollection[oryUIListID].sprItemDivider[oryUIListItemID], GetSpriteXByOffset(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]), GetSpriteYByOffset(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]) + GetSpriteHeight(OryUIListCollection[oryUIListID].sprItemContainer[oryUIListItemID]))
	endif
endfunction

foldend