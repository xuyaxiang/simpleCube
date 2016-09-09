//
//  ViewController.m
//  Cube
//
//  Created by enghou on 16/9/9.
//  Copyright © 2016年 xyxorigation. All rights reserved.
//

#import "ViewController.h"
typedef struct {
    GLKVector3 position;
    GLKVector3 normal;
}SceneVertex;
static const SceneVertex p[36] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    {{0.5f, -0.5f, -0.5f},        {1.0f, 0.0f, 0.0f}},
    {{0.5f, 0.5f, -0.5f},         {1.0f, 0.0f, 0.0f}},
    {{0.5f, -0.5f, 0.5f},         {1.0f, 0.0f, 0.0f}},
    {{0.5f, -0.5f, 0.5f},         {1.0f, 0.0f, 0.0f}},
    {{0.5f, 0.5f, -0.5f},          {1.0f, 0.0f, 0.0f}},
    {{0.5f, 0.5f, 0.5f},         {1.0f, 0.0f, 0.0f}},
    
    {{0.5f, 0.5f, -0.5f},         {0.0f, 1.0f, 0.0f}},
    {{-0.5f, 0.5f, -0.5f},        {0.0f, 1.0f, 0.0f}},
    {{0.5f, 0.5f, 0.5f},          {0.0f, 1.0f, 0.0f}},
    {{0.5f, 0.5f, 0.5f},          {0.0f, 1.0f, 0.0f}},
    {{-0.5f, 0.5f, -0.5f},        {0.0f, 1.0f, 0.0f}},
    {{-0.5f, 0.5f, 0.5f},         {0.0f, 1.0f, 0.0f}},
    
    {{-0.5f, 0.5f, -0.5f},        {-1.0f, 0.0f, 0.0f}},
    {{-0.5f, -0.5f, -0.5f},       {-1.0f, 0.0f, 0.0f}},
    {{-0.5f, 0.5f, 0.5f},         {-1.0f, 0.0f, 0.0f}},
    {{-0.5f, 0.5f, 0.5f},         {-1.0f, 0.0f, 0.0f}},
    {{-0.5f, -0.5f, -0.5f},       {-1.0f, 0.0f, 0.0f}},
    {{-0.5f, -0.5f, 0.5f},        {-1.0f, 0.0f, 0.0f}},
    
    {{-0.5f, -0.5f, -0.5f},       {0.0f, -1.0f, 0.0f}},
    {{0.5f, -0.5f, -0.5f},        {0.0f, -1.0f, 0.0f}},
    {{-0.5f, -0.5f, 0.5f},        {0.0f, -1.0f, 0.0f}},
    {{-0.5f, -0.5f, 0.5f},        {0.0f, -1.0f, 0.0f}},
    {{0.5f, -0.5f, -0.5f},        {0.0f, -1.0f, 0.0f}},
    {{0.5f, -0.5f, 0.5f},         {0.0f, -1.0f, 0.0f}},
    
    {{0.5f, 0.5f, 0.5f},          {0.0f, 0.0f, 1.0f}},
    {{-0.5f, 0.5f, 0.5f},         {0.0f, 0.0f, 1.0f}},
    {{0.5f, -0.5f, 0.5f},         {0.0f, 0.0f, 1.0f}},
    {{0.5f, -0.5f, 0.5f},         {0.0f, 0.0f, 1.0f}},
    {{-0.5f, 0.5f, 0.5f},         {0.0f, 0.0f, 1.0f}},
    {{-0.5f, -0.5f, 0.5f},        {0.0f, 0.0f, 1.0f}},
    
    {{0.5f, -0.5f, -0.5f},        {0.0f, 0.0f, -1.0f}},
    {{-0.5f, -0.5f, -0.5f},       {0.0f, 0.0f, -1.0f}},
    {{0.5f, 0.5f, -0.5f},         {0.0f, 0.0f, -1.0f}},
    {{0.5f, 0.5f, -0.5f},         {0.0f, 0.0f, -1.0f}},
    {{-0.5f, -0.5f, -0.5f},       {0.0f, 0.0f, -1.0f}},
    {{-0.5f, 0.5f, -0.5f},        {0.0f, 0.0f, -1.0f}}
};
@interface ViewController ()
@property(nonatomic,strong)GLKBaseEffect *effect;
@property(nonatomic)float rotation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view=(GLKView *)self.view;
    view.context=[[EAGLContext alloc]initWithAPI:2];
    [EAGLContext setCurrentContext:view.context];
    _effect=[[GLKBaseEffect alloc]init];
    _effect.light0.enabled=GL_TRUE;
    _effect.light0.diffuseColor=GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    view.drawableDepthFormat=GLKViewDrawableDepthFormat16;
    GLuint name;
    glGenBuffers(1, &name);
    glBindBuffer(GL_ARRAY_BUFFER, name);
    glBufferData(GL_ARRAY_BUFFER, sizeof(p), p, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL+offsetof(SceneVertex, position));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL+offsetof(SceneVertex, normal));
    glEnable(GL_DEPTH_TEST);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)update{
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65), aspect, 0.1f, 100);
    self.effect.transform.projectionMatrix = projectionMatrix;
    _rotation+=0.05f;
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 1.0f, 0.0f, 0.0f);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0, 0, 0, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [_effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, sizeof(p)/sizeof(SceneVertex));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
