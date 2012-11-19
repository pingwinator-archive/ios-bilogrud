//
//  Shader.fsh
//  SimpleShader
//
//  Created by Natasha on 16.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

varying lowp vec4 colorVarying;
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
void main()
{
    //gl_FragColor = colorVarying;
    gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
}
