Shader"Custom/TestiShader"
{
    Properties
    {  
        _Color("Color",Color) = (1,1,1,1)
    }


    SubShader
    {
        Tags { 
                "RenderType"        =   "Opaque" 
                "RenderPipeline"    =   "UniversalPipeline" 
                "Queue"             =   "Geometry"
            }



        Pass
        {
        Name "OmaPass"
        Tags
        {
        "LightMode" = "UniversalForward"
        }


        
       HLSLPROGRAM
       #pragma vertex Vert
       #pragma fragment Frag

       #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/core.hlsl"
        

       struct Attributes{
       float3 positionOS : POSITION;
       };

       struct Varyings{
        float4 positionHCS : SV_POSITION;
        float3 positionWS : TEXCOORD0;
        };


//cbuffer UnityPerMaterial
//{
 //float4 _Color;
//};

        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        CBUFFER_END



        Varyings Vert(const Attributes input)
        {
	        Varyings output;
	        output.positionHCS = TransformObjectToHClip(input.positionOS);
            output.positionWS = TransformObjectToWorld(input.positionOS);
	        return output;
        }

        float4 Frag(const Varyings input) : SV_TARGET
        {
    return _Color * clamp(input.positionWS.x, 0, 1);
}



	ENDHLSL

}
}
}