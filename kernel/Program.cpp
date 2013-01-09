//
//  Program.c
//  kernel
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#include <stdio.h>
#include "Program.h"


namespace mqyy {
namespace kernel{

    Program::Program(const char*szName)
    :m_strName(szName)
    {
        
    }
    Program::~Program()
    {
        for(size_t ix = 0;ix < m_Sections.size();++ ix)
        {
            m_Sections[ix]->Release();
        }
    }
    
    Program::RetType Program::AddSection(const char* szName, const char*szPath)
    {
        Section* pSection = new Section(szName, this, szPath);
        m_Sections.push_back(pSection);
        pSection->AddRef();
        return RetSuccess;
    }
}
}