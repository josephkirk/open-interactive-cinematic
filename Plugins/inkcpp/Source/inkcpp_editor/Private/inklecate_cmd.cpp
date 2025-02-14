/* Copyright (c) 2024 Julian Benda
 *
 * This file is part of inkCPP which is released under MIT license.
 * See file LICENSE.txt or go to 
 * https://github.com/JBenda/inkcpp for full license details. 
 */
#pragma once

#include "Kismet/GameplayStatics.h"
#include "string"

inline std::string get_inklecate_cmd() {
	FString platform = UGameplayStatics::GetPlatformName();
	if (platform == TEXT("Windows")) {
		return std::string("Source/ThirdParty/inklecate/windows/inklecate.exe");
	} else if (platform == TEXT("Mac")) {
		return std::string("Source/ThirdParty/inklecate/mac/inklecate");
	} else if (platform == TEXT("Linux")) {
		return std::string("Source/ThirdParty/inklecate/linux/inklecate");
	} else {
		// UE_LOG(InkCpp, Warning, TEXT("Platform: '%s' is not know. For compiling a .ink file a system wide 'inklecate' executable wil be tried to use."), platform);
		return std::string("inklecate");
	}
}
