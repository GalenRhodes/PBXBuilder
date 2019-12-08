/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBX_GNUstep_vers.c
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/16/19
 * DESCRIPTION: If building under XCode (actually it's the xcodebuild
 *              command-line app that gets called) this file would be
 *              automatically generated and stored in the temporary
 *              build files as "PBX_vers.c". So for GNUstep I'm simply
 *              creating a static version called "PBX_GNUstep_vers.c"
 *              so the linking doesn't fail.
 *
 * Copyright © 2019 Project Galen. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *//************************************************************************/

extern const unsigned char PBXVersionString[];
extern const double        PBXVersionNumber;

const unsigned char PBXVersionString[] __attribute__ ((used)) = "@(#)PROGRAM:Moscow  PROJECT:PBXBuilder-1" "\n";
const double        PBXVersionNumber __attribute__ ((used))   = (double)1.;
