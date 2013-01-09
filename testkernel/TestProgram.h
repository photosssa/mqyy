//
//  TestProgram.h
//  testkernel
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#ifndef mqyy__testkernel__TestProgram__
#define mqyy__testkernel__TestProgram__

#include <iostream>
#include <stdlib.h>
#include "Program.h"

namespace mqyy {
namespace kernel{
namespace test{
    class TestProgramFactory
    {
    public:
        Program* Create()
        {
            char szName[512]="测试节目";
            char szIndex[10];
            itoa(szIndex, m_ulIndex);
            strcat(szName,szIndex);
            Program* pProgram = new Program(szName);
            char szSectionName[512];
            for (unsigned long ix = 0; ix < m_ulIndex; ++ ix)
            {
                strcpy(szSectionName, szName);
                strcat(szSectionName, "-");
                itoa(szIndex, ix);
                strcat(szSectionName, szIndex);
                pProgram->AddSection(szSectionName, "");
            }
            return pProgram;
        }
                                                    
    protected:
        unsigned long m_ulIndex;
                                                    
    };
}
}
}


#endif /* defined(mqyy__testkernel__TestProgram__) */
