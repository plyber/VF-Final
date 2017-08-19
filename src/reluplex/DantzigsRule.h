/*********************                                                        */
/*! \file DantzigsRule.h
** \verbatim
** Top contributors (to current version):
**   Guy Katz
** This file is part of the Marabou project.
** Copyright (c) 2016-2017 by the authors listed in the file AUTHORS
** in the top-level source directory) and their institutional affiliations.
** All rights reserved. See the file COPYING in the top-level source
** directory for licensing information.\endverbatim
**/

#ifndef __DantzigsRule_h__
#define __DantzigsRule_h__

#include "EntrySelectionStrategy.h"

class String;

class DantzigsRule : public EntrySelectionStrategy
{
public:
    /*
      Apply Dantzig's rule: choose the candidate associated with the
      largest coefficient (in absolute value) in the cost function.
    */
    bool select( ITableau &tableau, const Set<unsigned> &excluded );

    static void log( const String &message );
};

#endif // __DantzigsRule_h__

//
// Local Variables:
// compile-command: "make -C .. "
// tags-file-name: "../TAGS"
// c-basic-offset: 4
// End:
//
