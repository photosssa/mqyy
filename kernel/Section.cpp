//
//  Section.c
//  kernel
//
//  Created by Tsukasa on 12-12-30.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#include <stdio.h>
#include "Section.h"
#include "Program.h"


namespace mqyy {
namespace kernel{
    Section::Section(const char* szName, const Program* pProgram, const char* szPath)
    : m_strName(szName)
    , m_strPath(szPath)
    , m_pProgram(pProgram)
    {
       
    }
}
}
