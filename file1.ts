export class Test1 {

    private text1: string;
    private text2: string;

    constructor(){
        this.text1 = 'Test1';
        this.text2 = 'Test2';
    }

    foo123456789():void{
        console.log("init");
        console.log(this.text1);
        console.log(this.text2);
        console.log("end");
    }
}